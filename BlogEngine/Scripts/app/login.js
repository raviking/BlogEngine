
$(document).ready(function () {

    //inilizing icheck for checkbox
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    $("#UserName").focus(function () {
        $("#spnUserName").hide();
    });
    $("#Password").focus(function () {
        $("#spnPassword").hide();
    });
});

function Login() {
    if (ValidateLoginForm()) {
        var loginModel = {
            UserName: $("#UserName").val(),
            Password: $("#Password").val(),
            ReturnUrl: $("#hdnReturnUrl").val()
        };

        $.ajax({
            url: "Login",
            dataType: 'json',
            type: 'POST',
            data:loginModel,
            success: function (data) {
                debugger;
                if (data != null && data.IsSucess == true ) {
                    if (data.ResponseMessage != "" && data.ResponseMessage != null)
                        window.location.href = data.ResponseMessage;
                    else
                        window.location.href = HostAddress + URIGetUserLogin;
                }
                else {
                    $("#spnLoginValMsg").text(data.ResponseMessage);
                }
            }
        });
    }
    else {
        return false;
    }
}

function ValidateLoginForm() {
    var result = true;
    if ($("#UserName").val().trim()=="") {
        $("#spnUserName").show();
        result = false;
    }
    if ($("#Password").val().trim()=="") {
        $("#spnPassword").show();
        result = false;
    }
    return result;
}

//Initializes Login method on 'Enter' click  from keyboard
$(document).keypress(function (e) {
    if (e.which == 13) {
        Login();
    }
});