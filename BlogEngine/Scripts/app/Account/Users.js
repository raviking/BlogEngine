
$(function () {
    $("#tblUsers").DataTable();
    //$("#tblAllPosts").DataTable({
    //    'paging': true,
    //    'lengthChange': false,
    //    'searching': false,
    //    'ordering': true,
    //    'info': true,
    //    'autoWidth': false
    //});
});

function DeleteUser(userid) {
    debugger;
    var url = HostAddress + "/Account/DeleteUser?userId=" + userid;
    var result = confirm("Sure you want to delete user?");
    if (result) {
        $.post(url, function (data) {
            debugger;
            if (data.IsSucess == true) {
                alert("User deleted successfully!");
                console.log("User deleted successfully!");
                window.location.href = HostAddress + "/Account/Users";
            }
        });
    }    
}