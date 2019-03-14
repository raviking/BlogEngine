
$(function () {
    $("#txtfirstname").focus(function () {
        $("#spntxtfirstname").text("");
    });
    $("#txtlastname").focus(function () {
        $("#spntxtlastname").text("");
    });
    $("#txtemail").focus(function () {
        $("#spntxtemail").text("");
    });
    $("#ddlCountry").change(function () {
        if ($("#txtemail").val() != "Select Country") {
            $("#spntxtemail").text("");
        }
    });
});

function saveSubscriberInfo() {

    if (validateform()) {
        var url = HostAddress + "/Blog/Subscribe";
        var objData = {
            UserId:0,
            FirstName: $.trim($("#txtfirstname").val()),
            LastName: $.trim($("#txtlastname").val()),
            Email: $.trim($("#txtemail").val()),
            RegistrationDate: new Date(),
            Role: "4", //SUBSCRIBER,
            UserStatus: 101, //Active
            Country: $("#ddlCountry").val()
        };
        $.post(url, { objUser: objData }, function (res) {
            if (res.IsSucess) {
                swal("You are successfully subscribed we will noftify you when updates avilable");
                //window.location.href = HostAddress;
            }
        });
    }
}

function validateform() {

    var result = true;
    //var emailReg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if ($.trim($("#txtfirstname").val()) == undefined || $.trim($("#txtfirstname").val()) == "") {
        $("#spntxtfirstname").text("First Name can not be empty");
        result = false;
    }
    else {
        $("#spntxtfirstname").text("");
    }
    if ($.trim($("#txtlastname").val()) == undefined || $.trim($("#txtlastname").val()) == "") {
        $("#spntxtlastname").text("Last Name can not be empty");
        result = false;
    }
    else {
        $("#spntxtlastname").text("");
    }
    if ($.trim($("#txtemail").val()) == undefined || $.trim($("#txtemail").val()) == "") {
        $("#spntxtemail").text("Email can not be empty");
        result = false;
    }
    //else if (!emailReg.test($("#txtemail").val())) {
    //    $("#spntxtemail").text("Please enter valid email");
    //    result = false;
    //}
    else {
        $("#spntxtemail").text("");
    }
    if ($.trim($("#ddlCountry").val()) == undefined || $.trim($("#ddlCountry").val()) == "") {
        $("#spnddlCountry").text("Please select your country");
        result = false;
    }
    else {
        $("#spnddlCountry").text("");
    }
    return result;
}