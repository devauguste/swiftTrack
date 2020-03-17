let dropdown_triggers = document.querySelectorAll('.dropdown-trigger');
let dropdowns = document.querySelectorAll('.dropdown');
Array.from(dropdown_triggers).forEach(trigger => {
    trigger.onclick = function (e) {
        e.preventDefault();
        hide_all_dropdowns();
        this.parentNode.querySelector('.dropdown').style.display = "block";
    }
});

function hide_all_dropdowns() {
    Array.from(dropdowns).forEach(dropdown => {
        dropdown.style.display = "none";
    });
}