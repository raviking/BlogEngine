
$(function () {
    //comments table initialization
    $("#tblAllComments").DataTable();
});

function DeleteComment(commentid) {
    var url = HostAddress + "/Account/DeleteComment?commentId=" + commentid;
    var result = confirm("Sure you want to delete?");
    if (result) {
        $.post(url, function (data) {
            if (data.IsSucess == true) {
                alert("Comment Deleted Successfully");
                window.location.href = HostAddress + "/Account/Comments";
            }
        });
    }    
}

function displayEditCommentForm(commentid) {
    debugger;
    var url = HostAddress + "/Account/EditCommentViewPartial?commentId=" + commentid;
}

function displayReplyTextBox(commentId,postId) {
    debugger;
    var element = "<textarea rows='10' id='txt_reply_content" + commentId + "' class='form-control'></textarea>";
    element += "<span id='spn_txt_reply_content' style='display:none;'></span>";
    $("#reply_comment").empty();
    $("#reply_comment").html(element);
    $("#reply_comment").dialog({
        height: 'auto',
        width: 700,
        resizable: false,
        draggable: false,
        modal:true,
        title: "Reply Comment",
        closeOnEscape: false,
        open: function(event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        },
        buttons: [
            {
                text: "Reply",
                "class": "btn btn-primary",
                click: function () {
                    //save reply content
                    if ($("#txt_reply_content").val().trim() != "" || $("#txt_reply_content").val().trim() != null) {
                        var objReply = {
                            Comment_Id: 0,
                            Comment_Content: $("#txt_reply_content").val().trim(),//reply content
                            Comment_Approved: true,
                            Comment_Date: new Date(),
                            Comment_Author: null,//will get comment author name from session
                            Comment_AuthorEmail: null,//will get author email from session
                            Comment_Parent: commentId,
                            Comment_PostId: postId,
                        };

                        $.ajax({
                            url: 'Account/SaveCommentReply',
                            method: 'POST',
                            datatype: 'json',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(objReply),
                            success: function (response) {
                                if (response.IsSucess == true) {
                                    $(this).dialog("close");
                                    window.location.href = HostAddress + "/Account/Comments";
                                }
                            },
                            error: function () {
                                console.log("Reply saving failed");
                                alert("Error occured while saving reply!");
                            }
                        });
                    }
                    else {
                        $("#spn_txt_reply_content").text("Reply can not be blank");
                        $("#spn_txt_reply_content").show();
                    }
                    
                }
            },
            {
                text: "Cancel",
                "class": "btn btn-default",
                click: function () {
                    $(this).dialog("close");
                }
            }
        ]
    });
}