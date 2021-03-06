﻿
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
    var url = HostAddress + "/Account/EditCommentViewPartial?commentId=" + commentid;
}

function displayReplyTextBox(commentId,postId) {
    var element = "<textarea rows='10' id='txt_reply_content' class='form-control'></textarea>";
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
                    if ($("#txt_reply_content").val() != "" || $("#txt_reply_content").val() != null) {
                        var objReply = {
                            ReplyId: 0,
                            Reply_Content: $("#txt_reply_content").val(),//reply content
                            Reply_Author: null,
                            Reply_Date: new Date(),
                            Reply_CoommentId: commentId,//will get comment author name from session                            
                        };

                        $.ajax({
                            url: 'SaveCommentReply',
                            method: 'POST',
                            datatype: 'json',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(objReply),
                            success: function (response) {
                                if (response.IsSucess == true) {                                    
                                    swal("Reply sent for the Comment");
                                    //$(this).dialog("close");
                                    window.location.href = HostAddress + "/Account/Comments";
                                }
                            },
                            error: function () {
                                console.log("Reply saving failed");
                                swal("Error occured while saving reply!");
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