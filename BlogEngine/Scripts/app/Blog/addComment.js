
$(function () {
    
});

function AddComment() {
    if (validateForm()) {
        var objComment = {
            Comment_Id: 0,
            Comment_Content: $("#txt_comment_content").val(),
            Comment_Date: new Date(),
            Comment_Author: $("#txt_comment_author_name").val(),
            Comment_AuthorEmail: $("#txt_comment_author_email").val(),
            Comment_Parent: 0,
            Comment_Approved: 0,
            Comment_PostId: $("#hdnPostId").val()
        }

        $.ajax({
            url: 'Blog/SaveComment',
            method: 'POST',
            datatype: 'json',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(objComment),
            success: function (response) {
                if (response.IsSucess == true) {
                    console.log("comment added successfully!");
                    $("#spnAddCommentSuccessDisplay").show();
                    $("#spnAddCommentSuccessDisplay").text("Comment submited for moderation");
                }
            },
            error: function () {
                console.log("Adding comment failed");              
            }
        });
    }
}

function validateForm() {
    debugger;
    var re_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var result = true;
    if ($("#txt_comment_author_name").val().trim() == "" || $("#txt_comment_author_name").val().trim() == undefined) {
        $("#spntxt_comment_author_name").show();
        $("#spntxt_comment_author_name").text("Name Required");
        result = false;
    }
    if ($("#txt_comment_author_email").val().trim() == "" || $("#txt_comment_author_email").val().trim() == undefined) {
        $("#spntxt_comment_author_email").show();
        $("#spntxt_comment_author_email").text("Email Required");
        result = false;
    }
    //else if (!re_email.test($("#txt_comment_author_email").val()) == false) {
    //    $("#spntxt_comment_author_email").show();
    //    $("#spntxt_comment_author_email").text("Please Enter Valid Email");
    //    result = false;
    //}
    if ($("#txt_comment_content").val().trim() == "" || $("#txt_comment_content").val().trim() == undefined) {
        $("#spntxt_comment_content").show();
        $("#spntxt_comment_content").text("Minimum 50 words Required");
        result = false;
    }
    return result;
}