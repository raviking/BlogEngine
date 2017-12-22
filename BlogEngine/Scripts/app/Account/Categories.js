
$(function () {
    $("#tblCategories").DataTable();
    //$("#tblAllPosts").DataTable({
    //    'paging': true,
    //    'lengthChange': false,
    //    'searching': false,
    //    'ordering': true,
    //    'info': true,
    //    'autoWidth': false
    //});

    $("#txtCategoryName").focus(function () {
        if ($("#txtCategoryName").val() != "") {
            $("#spntxtCategoryName").hide();
        }
    });
    $("#txtCategoryUrlSlug").focus(function () {
        if ($("#txtCategoryUrlSlug").val() != "") {
            $("#spntxtCategoryUrlSlug").hide();
        }
    });

});

function checkIsSlugExists() {
    var categoryUrlSlug = $("#txtCategoryUrlSlug").val().trim();
    if (categoryUrlSlug != null && categoryUrlSlug != "") {
        var url = HostAddress + "/Account/IsCategorySlugExists?categorySlug=" + categoryUrlSlug
        $.get(url, function (data) {
            if (data.IsSucess == true) {
                $("#spntxtCategoryUrlSlug").show();
                $("#spntxtCategoryUrlSlug").text("Slug already exists");
                $("#txtCategoryUrlSlug").val("");
                console.log("CategorySlug already exists");
            }
        });
    }
}

// Adding new Tag
function addNewCategory(type) {
    if (validateForm()) {
        var objCategory = {
            CategoryId: $("#hdnCategoryId").val() != null ? $("#hdnCategoryId").val() : 0,
            CategoryName: $("#txtCategoryName").val().trim(),
            CategoryUrlSlug: $("#txtCategoryUrlSlug").val().trim(),
            CategoryDescription: $("#txtCategoryDescription").val().trim()
        }
        $.ajax({
            url: 'SaveCategory',
            method: 'POST',
            datatype: 'json',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(objCategory),
            success: function (data) {
                if (data.IsSucess == true) {
                    if (type == "ADD") {
                        alert("Category saved successfully");
                    }
                    else {
                        alert("Category updated successfully");
                    }
                    window.location.href = HostAddress + "/Account/Categories";
                }
            },
            error: function () {
                alert("Saving Category failed!");
                console.log("Saving Category failed!");
            }
        });
    }
}

//deletes Tag
function deleteCategory(categoryId) {
    var url = HostAddress + "/Account/DeleteCategory?categoryId=" + categoryId;
    var response = confirm("Confirm deletion of Category");
    if (response) {
        $.post(url, function (data) {
            if (data.IsSucess == true) {
                alert("Category deleted successfully");
                console.log("A Category with id: " + categoryId + " deleted successfully");
                window.location.href = HostAddress + "/Account/Categories";
            }
            if (data.IsSucess == false) {
                alert("Category deletion failed");
            }
        });
    }
}

//Reset form
function resetForm() {
    $("#txtCategoryName").val("");
    $("#txtCategoryUrlSlug").val("");
    $("#txtCategoryDescription").val("");
}

//Validate Form
function validateForm() {
    var result = true;
    if ($("#txtCategoryName").val().trim() == "" || $("#txtCategoryName").val().trim() == undefined) {
        $("#spntxtCategoryName").show();
        $("#spntxtCategoryName").text("Name Required");
        result = false;
    }
    if ($("#txtCategoryUrlSlug").val().trim() == "" || $("#txtCategoryUrlSlug").val().trim() == undefined) {
        $("#spntxtCategoryUrlSlug").show();
        $("#spntxtCategoryUrlSlug").text("UrlSlug Required");
        result = false;
    }
    return result;
}