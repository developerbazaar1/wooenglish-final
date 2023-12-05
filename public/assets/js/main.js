(function () {
	"use strict";

	var treeviewMenu = $('.app-menu');

	// Toggle Sidebar
	$('[data-toggle="sidebar"]').click(function(event) {
		event.preventDefault();
		$('.app').toggleClass('sidenav-toggled');
	});

	// Activate sidebar treeview toggle
	$("[data-toggle='treeview']").click(function(event) {
		event.preventDefault();
		if(!$(this).parent().hasClass('is-expanded')) {
			treeviewMenu.find("[data-toggle='treeview']").parent().removeClass('is-expanded');
		}
		$(this).parent().toggleClass('is-expanded');
	});

	// Set initial active toggle
	$("[data-toggle='treeview.'].is-expanded").parent().toggleClass('is-expanded');

	//Activate bootstrip tooltips
	$("[data-toggle='tooltip']").tooltip();



	//to keep the current page active
	for (var nk = window.location,
	o = $(".app-menu a").filter(function() {
	return this.href == nk;
	})
	.addClass("active")
	.parent()
	.addClass("active");;) {
	// console.log(o)
	if (!o.is("li")) break;
	o = o.parent()
	.addClass("your_class")
	.parent()
	.addClass("active");
	}
	// ______________Active Class
	$(document).ready(function() {
	$(".treeview-menu a").each(function() {
	var pageUrl = window.location.href.split(/[?#]/)[0];
	if (this.href == pageUrl) {
	$(this).addClass("active");
	$(this).parent().addClass("active"); // add active to li of the current link
	$(this).parent().parent().prev().addClass("active"); // add active class to an anchor
	$(this).parent().parent().prev().click(); // click the item to make it drop
	}
	});
	});


})();
