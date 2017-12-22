
$(function () {
    var userid = $("#hdnUserId").val();
    var url = HostAddress + "/Account/UserDetailsById?userId=" + userid;
    $.get(url, function (data) {
        debugger;
        if (data != null) {            
            $("#txtUserName").val(data.UserName);
            $("#txtPassword").val(data.Password);
            $("#txtEmail").val(data.Email);
            $("#txtFirstName").val(data.FirstName);
            $("#txtLastName").val(data.LastName);
            if (data.Gender == "Male") {
                $("#rdlMale").prop("checked",true);
            }
            else {
                $("#rdlFemale").prop("checked", true);
            }
            $("#ddlRoles option").each(function () {
                if ($(this).text() == data.Role) {
                    $(this).attr('selected', 'selected');
                }
            });
            $("#ddlCountry").val(data.Country);
            $("#ddlUserStatus").val(data.UserStatus);
        }
    });
});