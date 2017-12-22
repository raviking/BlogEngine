
$(function () {
    // Tags grid initialization
    $("#tblTags").DataTable();
    //$("#tblAllPosts").DataTable({
    //    'paging': true,
    //    'lengthChange': false,
    //    'searching': false,
    //    'ordering': true,
    //    'info': true,
    //    'autoWidth': false
    //});

    $("#txtTagName").focus(function () {
        if ($("#txtTagName").val() != "") {
            $("#spntxtTagName").hide();
        }
    });
    $("#txtTagUrlSlug").focus(function () {
        if ($("#txtTagUrlSlug").val() != "") {
            $("#spntxtTagUrlSlug").hide();
        }
    });   

});

function checkIsSlugExists() {
    var tagUrlSlug = $("#txtTagUrlSlug").val().trim();
    if (tagUrlSlug != null && tagUrlSlug != "") {
        var url = HostAddress + "/Account/IsTagSlugExists?tagSlug=" + tagUrlSlug
        $.get(url, function (data) {
            if (data.IsSucess == true) {
                $("#spntxtTagUrlSlug").show();
                $("#spntxtTagUrlSlug").text("Slug already exists");
                $("#txtTagUrlSlug").val("");
                console.log("Tagslug already exists");
            }
        });
    }
}

// Adding new Tag
function addNewTag(type) {
    if (validateForm()) {
        var objTag = {
            TagId: $("#hdnTagId").val()!=null ? $("#hdnTagId").val() : 0,
            TagName: $("#txtTagName").val().trim(),
            TagUrlSlug: $("#txtTagUrlSlug").val().trim(),
            TagDescription: $("#txtTagDescription").val().trim()
        }
        $.ajax({
            url: 'SaveTag',
            method: 'POST',
            datatype: 'json',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(objTag),
            success: function (data) {
                if (data.IsSucess == true) {
                    if (type == "ADD") {
                        alert("Tag saved successfully");
                    }
                    else {
                        alert("Tag updated successfully");
                    }
                    window.location.href = HostAddress + "/Account/Tags";
                }
            },
            error: function () {
                alert("Saving Tag failed!");
                console.log("Saving Tag failed!");
            }
        });
    }
}

//deletes Tag
function deleteTag(tagId) {
    var url = HostAddress + "/Account/DeleteTag?tagId=" + tagId;
    var response = confirm("Confirm deletion of Tag");
    if (response) {
        $.post(url, function (data) {
            if (data.IsSucess == true) {
                alert("Tag deleted successfully");
                console.log("A Tag with id: " + tagId + " deleted successfully");
                window.location.href = HostAddress + "/Account/Tags";
            }
            if (data.IsSucess == false) {
                alert("Tag deletion failed");
            }
        });
    }
}

//Reset form
function resetForm() {
    $("#txtTagName").val("");
    $("#txtTagUrlSlug").val("");
    $("#txtTagDescription").val("");
}

//Validate Form
function validateForm() {
    var result = true;
    if ($("#txtTagName").val().trim() == "" || $("#txtTagName").val().trim() == undefined) {
        $("#spntxtTagName").show();
        $("#spntxtTagName").text("TagName Required");
        result = false;
    }
    if ($("#txtTagUrlSlug").val().trim() == "" || $("#txtTagUrlSlug").val().trim() == undefined) {
        $("#spntxtTagUrlSlug").show();
        $("#spntxtTagUrlSlug").text("TagSlug Required");
        result = false;
    }
    return result;
}