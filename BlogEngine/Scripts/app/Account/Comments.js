
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
    $.get(url, function (data) {
        if (data != null) {
            $("#DisplayForms").dialog();
        }
    });
}