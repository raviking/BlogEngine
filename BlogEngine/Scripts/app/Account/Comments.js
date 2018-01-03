
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

function displayReplyTextBox(commentid) {
    debugger;
    //var result = "<tr id='replyrow_"+commentid+"'><td><textbox id='txt_replybox_" + commentid + "' class='form-control'></textarea>";
    //result += "<input type='button' class='btn btn-default' value='Cancel' /><input type='button' class='btn btn-success' value='Reply' /></td></tr>";
    //$("#tblAllComments").append(result);

    //$("#displaybox").dialog({
    //    resizable: false,
    //    height: 300,
    //    width: 500,
    //    modal: false,
    //    title: 'sample modal popup',
    //    buttons: {
    //        "Delete all items": function () {
    //            $(this).dialog("close");
    //        },
    //        Cancel: function () {
    //            $(this).dialog("close");
    //        }
    //    }
    //});
}

function openmodel() {
    $("#disply").dialog();
}