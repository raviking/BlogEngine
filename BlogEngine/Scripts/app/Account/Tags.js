
$(function () {
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
    var tagSlug = $("#txtTagUrlSlug").val().trim();
    
}

function addNewTag() {
    if (validateForm()) {
        var objTag = {
            TagId:0,
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
            success: function (response) {
                debugger;
                if (response.IsSucess == true) {
                    alert("Tag Saved Successfully");
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

function resetForm() {
    $("#txtTagName").val("");
    $("#txtTagUrlSlug").val("");
    $("#txtTagDescription").val("");
}

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