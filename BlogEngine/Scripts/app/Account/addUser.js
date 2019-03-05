
$(function () {
    var userid = $("#hdnUserId").val();
    if (userid != undefined && userid != "") {
        var url = HostAddress + "/Account/UserDetailsById?userId=" + userid;
        $.get(url, function (data) {
            if (data != null) {
                $("#txtUserName").val(data.UserName);
                $("#txtPassword").val(data.Password);
                $("#txtEmail").val(data.Email);
                $("#txtFirstName").val(data.FirstName);
                $("#txtLastName").val(data.LastName);
                if (data.Gender == "Male" || data.Gender=="MALE") {
                    $("#rdlMale").prop("checked", true);
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
    }   

    $("#txtUserName").focus(function () {
        if ($("#txtUserName").val() != "") {
            $("#spntxtUserName").hide();
        }        
    });
    $("#txtEmail").focus(function () {
        if ($("#txtEmail").val() != "") {
            $("#spntxtEmail").hide();
        }
    });
    $("#txtPassword").focus(function () {
        if ($("#txtPassword").val() != "") {
            $("#spntxtPassword").hide();
        }
    });
    $("#txtFirstName").focus(function () {
        if ($("#txtFirstName").val() != "") {
            $("#spntxtFirstName").hide();
        }
    });
    $("#ddlRoles").focus(function () {
        if ($("#ddlRoles").val() != "") {
            $("#spnddlRoles").hide();
        }
    });
    $("#ddlCountry").focus(function () {
        if ($("#ddlCountry").val() != "") {
            $("#spnddlCountry").hide();
        }
    });
    $("#ddlUserStatus").focus(function () {
        if ($("#ddlUserStatus").val() != "") {
            $("#spnddlUserStatus").hide();
        }
    });
});

function addNewUser(type) {
    if (validateForm()) {
        var objUser = {
            UserId: $("#hdnUserId").val()!=null ? $("#hdnUserId").val() : 0,
            FirstName: $("#txtFirstName").val().trim(),
            LastName: $("#txtLastName").val().trim(),
            UserName: $("#txtUserName").val().trim(),
            Password: $("#txtPassword").val().trim(),
            Role: $("#ddlRoles").val(),
            Gender: $("#rdlMale").prop('checked') == true ? 'MALE' : 'FEMALE',
            Email: $("#txtEmail").val().trim(),
            UserStatus: $("#ddlUserStatus").val(),    //101 for active,102 for inactive
            Country: $("#ddlCountry").val(),
            Designation: "nothing",
        }

        $.ajax({
            url: 'SaveUser',
            method: 'POST',
            datatype: 'json',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(objUser),
            success: function (response) {
                if (response.IsSucess == true) {
                    if (type == 'ADD') {
                        alert("User Added Successfully");
                    }
                    else {
                        alert("User updated Successfully");
                    }
                    window.location.href = HostAddress + "/Account/Users";
                }                    
            },
            error: function () {
                if (type == 'ADD') {
                    console.log("Adding user failed");
                    alert("Saving User Failed!");
                }
                else {
                    console.log("Updating user failed");
                    alert("Updating User Failed!");
                }                
            }
        });
    }    
}

function resetUserForm() {

    $("#txtUserName").val("");
    $("#txtPassword").val("");
    $("#txtEmail").val("");
    $("#txtFirstName").val("");
    $("#txtLastName").val("");
    $("#rdlMale").prop('checked',false);
    $("#rdlFeMale").prop('checked', false);
    $("#ddlRoles").val("");
    $("#ddlCountry").val("");
    $("#ddlUserStatus").val("");
}

function validateForm() {

    var re_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var result = true;
    if ($("#txtUserName").val().trim() == "" || $("#txtUserName").val().trim() == undefined) {
        $("#spntxtUserName").show();
        $("#spntxtUserName").text("UserName Required");
        result = false;
    }
    if ($("#txtPassword").val().trim() == "" || $("#txtPassword").val().trim() == undefined) {
        $("#spntxtPassword").show();
        $("#spntxtPassword").text("Password Required");
        result = false;
    }
    if ($("#txtEmail").val().trim() == "" || $("#txtEmail").val().trim() == undefined) {
        $("#spntxtEmail").show();
        $("#spntxtEmail").text("Email Required");
        result = false;
    }
    else if (re_email.test($("#txtEmail").val()) == false) {
        $("#spntxtEmail").show();
        $("#spntxtEmail").text("Please Enter Valid Email");
        result = false;
    }
    if ($("#txtFirstName").val().trim() == "" || $("#txtFirstName").val().trim() == undefined) {
        $("#spntxtFirstName").show();
        $("#spntxtFirstName").text("First Name Required");
        result = false;
    }
    if ($("#ddlRoles").val() == "") {
        $("#spnddlRoles").show();
        $("#spnddlRoles").text("Please Select Role");
        result = false;
    }
    if ($("#ddlCountry").val() == "" ) {
        $("#spnddlCountry").show();
        $("#spnddlCountry").text("Please Select Country");
        result = false;
    }
    if ($("#ddlUserStatus").val() == "" ) {
        $("#spnddlUserStatus").show();
        $("#spnddlUserStatus").text("Please Select UserStatus");
        result = false;
    }
    if ($("#rdlMale").prop('checked') == false && $("#rdlFemale").prop('checked') == false) {
        $("#spnrdlGender").show();
        $("#spnrdlGender").text("Please Select Gender");
        result = false;
    }
    else {
        $("#spnrdlGender").hide();
    }
    return result;
}