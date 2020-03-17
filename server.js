const express = require("express");
const session = require("express-session");
const mustacheExpress = require("mustache-express");
const mysql = require("mysql");
const path = require("path");
const app = express();
const port = 3000;

var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "swifttrack"
});

connection.connect();


function generate(n) {
  var add = 1,
    max = 12 - add;

  if (n > max) {
    return generate(max) + generate(n - max);
  }

  max = Math.pow(10, n + add);
  var min = max / 10; // Math.pow(10, n) basically
  var number = Math.floor(Math.random() * (max - min + 1)) + min;

  return ("" + number).substring(add);
}


app.engine("html", mustacheExpress());
app.set("view engine", "html");
app.set("views", path.join(__dirname, "www"));
app.use(express.static(path.join(__dirname, "www")));
app.use(express.json());
app.use(
  session({
    secret: "swifttrack",
    saveUninitialized: false,
    resave: true,
    rolling: true,
    cookie: {
      expires: 100 * 1000
    }
  })
);

app.get("/", (req, res) => {
  res.sendFile("index.html", {
    root: path.join(__dirname, "www")
  });
});

app.get("/home", (req, res) => {
  res.sendFile("index.html", {
    root: path.join(__dirname, "www")
  });
});


app.get("/student-reports", (req, res) => {
  if (req.session.loggedin) {
    connection.query(
      "SELECT STUDENT_INFO.STUDENT_ID,FIRSTNAME,LASTNAME,GRADE,DESCRIPTION, SUM(HOUR) AS TOTAL_HOURS FROM STUDENT_INFO INNER JOIN AWARD_CATEGORY ON STUDENT_INFO.AWARD_CATEGORY_ID = AWARD_CATEGORY.AWARD_CATEGORY_ID RIGHT JOIN STUDENT_LOG ON STUDENT_INFO.STUDENT_ID = STUDENT_LOG.STUDENT_ID GROUP BY STUDENT_INFO.STUDENT_ID",
      function (err, result, fields) {
        if (err) throw err;

        var students = [];

        students.push(result);
        let count = 0;
        Object.keys(result).forEach(function (key) {
          result[key].COUNT_ID = ++count;
        });

        students = result;

        // res.sendFile("reports.html", {
        //   root: path.join(__dirname, "www")
        // });

        res.render("reports", {
          username: req.session.username,
          students: students
        });
      }
    );
  } else {
    res.redirect("/");
  }
});

app.get("/edit", (req, res) => {
  if (req.session.loggedin) {
    let id = req.query.id;

    connection.query(
      "SELECT * FROM STUDENT_INFO WHERE STUDENT_ID=?", [id],
      function (err, result, fields) {
        if (err) throw err;

        Object.keys(result).forEach(function (key) {

          connection.query(
            "SELECT DATE_FORMAT(DATE,'%d/%m/%Y') AS DATE,HOUR FROM STUDENT_LOG WHERE STUDENT_ID=?", [result[key].STUDENT_ID],
            function (err, result1, fields) {
              if (err) throw err;


              connection.query(
                "SELECT * FROM AWARD_CATEGORY",
                function (err, result2, fields) {
                  if (err) throw err;


                  res.render("edit", {
                    username: req.session.username,
                    data: result,
                    logs: result1,
                    category: result2
                  });

                });



            });

        });


      }
    );

  } else {
    res.redirect("/");
  }
});

app.get("/add", (req, res) => {
  if (req.session.loggedin) {


    connection.query(
      "SELECT * FROM AWARD_CATEGORY",
      function (err, result, fields) {
        if (err) throw err;

        res.render("addStudent", {
          username: req.session.username,
          category: result
        });

      });

  } else {
    res.redirect("/");
  }
});


app.get("/logout", (req, res) => {
  res.redirect('/');
});


app.post("/add_student", (req, res) => {
  let ret;
  let id = generate(7);
  let firstname = req.body.firstname.toUpperCase();
  let lastname = req.body.lastname.toUpperCase();
  let grade = req.body.grade;
  let category = req.body.category;
  let logs = req.body.logs;

  connection.query("INSERT INTO STUDENT_INFO (STUDENT_ID,FIRSTNAME,LASTNAME,GRADE,AWARD_CATEGORY_ID) VALUES (?,?, ?, ?, ?)", [id, firstname, lastname, grade, category], function (err, result) {
    if (err) throw err;

    console.log("logs...", logs)
    logs.forEach(log => {
      connection.query("INSERT INTO STUDENT_LOG (STUDENT_ID,DATE,HOUR) VALUES (?, ?, ?)", [id, log.date, log.hour], function (err, result) {
        if (err) throw err;
      });
    });

  });


  ret = {
    url: "/dashboard",
    msg: "Added successfully"
  };
  res.send(JSON.stringify(ret));



});


app.post("/update_student", (req, res) => {
  console.log("Get here...", req.body)
  let ret;
  let id = req.body.studentid;
  let firstname = req.body.firstname.toUpperCase();
  let lastname = req.body.lastname.toUpperCase();
  let grade = req.body.grade;
  let category = req.body.category;
  let logs = req.body.logs;



  connection.query(
    "SELECT * FROM STUDENT_INFO WHERE STUDENT_ID=?", [id],
    function (err, result, fields) {
      console.log("IDEXISTS", id)
      if (err) throw err;
      let updateQuery = "UPDATE STUDENT_INFO SET FIRSTNAME = ?, LASTNAME=?,GRADE=?,AWARD_CATEGORY_ID=? WHERE STUDENT_ID =?"
      connection.query(updateQuery, [firstname, lastname, grade, category, id], function (err, result) {
        if (err) {
          console.log("Did't update", err)
        }
        console.log("Result...", result)
      })
    })

    console.log("logs...", logs)
    /*
    logs.forEach(log => {
      connection.query("INSERT INTO STUDENT_LOG (STUDENT_ID,DATE,HOUR) VALUES (?, ?, ?)", [id, log.date, log.hour], function (err, result) {
        if (err) throw err;
      });
    });*/



  ret = {
    url: "/dashboard",
    msg: "Added successfully"
  };
  res.send(JSON.stringify(ret));



});



app.get("/dashboard", (req, res) => {
  if (req.session.loggedin) {
    connection.query(
      "SELECT STUDENT_INFO.STUDENT_ID,FIRSTNAME,LASTNAME,GRADE,DESCRIPTION, SUM(HOUR) AS TOTAL_HOURS FROM STUDENT_INFO INNER JOIN AWARD_CATEGORY ON STUDENT_INFO.AWARD_CATEGORY_ID = AWARD_CATEGORY.AWARD_CATEGORY_ID RIGHT JOIN STUDENT_LOG ON STUDENT_INFO.STUDENT_ID = STUDENT_LOG.STUDENT_ID GROUP BY STUDENT_INFO.STUDENT_ID",
      function (err, result, fields) {
        if (err) throw err;

        var students = [];

        students.push(result);
        let count = 0;
        Object.keys(result).forEach(function (key) {
          result[key].COUNT_ID = ++count;
        });

        students = result;

        res.render("dashboard", {
          username: req.session.username,
          students: students
        });
      }
    );
  } else {
    res.redirect("/");
  }
});




app.post("/auth", function (req, res) {
  let ret;
  let username = req.body.username;
  let password = req.body.password;
  if (username && password) {
    connection.query(
      "SELECT * FROM ADMIN_INFO WHERE username = ? AND password = ?",
      [username, password],
      (error, results, fields) => {
        if (results.length > 0) {
          req.session.loggedin = true;
          req.session.username = username;
          ret = {
            url: "/dashboard",
            msg: "Success"
          };
          res.send(JSON.stringify(ret));
        } else {
          ret = {
            url: null,
            msg: "Incorrect Username or Password!"
          };
          res.send(JSON.stringify(ret));
        }
        res.end();
      }
    );
  } else {
    res.send("Please enter Username and Password!");
    res.end();
  }
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));