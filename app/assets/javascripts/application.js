//= require jquery
//= require rails-ujs
//= require materialize-sprockets
//= require_tree .
$("select").formSelect();

$(".datepicker").datepicker({
    format: "mmmm dd, yyyy",
    yearRange: 15
});