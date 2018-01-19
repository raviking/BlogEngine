
$(function () {
    debugger;
    InitializeTinyMCE();
    var postid = $("#hdnPostId").val();
    $.ajax({
        url: 'GetPostDetailsById',
        method: 'GET',
        datatype: 'json',
        data: {postId:postid},
        success: function (data) {
            $("#txtPostTitle").val(data.Title);
            $("#txtPostUrlSlug").val(data.PostUrlSlug);
            $("#txtSearchDescription").val(data.PostMeta);
            //tinymce.get("txtPostBody").setContent(data.PostDescription);
            tinymce.activeEditor.setContent(data.PostDescription);
            $("#rdlCategory_" + data.CategoryId).prop('checked', true);
            for (var i = 0; i < data.Tags.length; i++) {
                $("#ddlTags option[value='"+data.Tags[i].TagId+"']").prop("selected", "selected");
            }
        },
        error: function () {
            alert("Unable to get post details from server");
            console.log("Unable to get post details from server");
        }
    });
});

//initilizing tinyMCE editor
function InitializeTinyMCE() {
    tinymce.init({
        //selector: "textarea",
        theme: "modern",
        height: 400,
        autoresize_min_height: 400,
        autoresize_max_height: 1000,
        mode: "specific_textareas",
        editor_selector: "txtPostBody",
        plugins: [
                "advlist autolink link image lists charmap print preview hr anchor pagebreak fullscreen",
                "searchreplace wordcount visualblocks visualchars insertdatetime media nonbreaking",
                "table contextmenu directionality paste textcolor responsivefilemanager code autoresize"
        ],
        menubar: false,
        toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link unlink anchor styleselect | responsivefilemanager charmap",
        toolbar2: "image media | forecolor backcolor  | print preview code paste table | hr anchor pagebreak visualblocks insertdatetime visualchars searchreplace | fullscreen",
        image_advtab: true,
        relative_urls: false,
        remove_script_host: false,
        document_base_url: HostAddress,
        media_live_embeds: true,
        paste_data_images: true,
        paste_as_text: true,
        plugin_preview_height: 550,
        plugin_preview_width: 1300,
        code_dialog_height: 550,
        code_dialog_width: 1000,
        wordcount_cleanregex: /[0-9.(),;:!?%#$?\x27\x22_+=\\\/\-]*/g,
        external_filemanager_path: HostAddress + "/filemanager/",
        external_plugins: { "filemanager": HostAddress + "/filemanager/plugin.min.js" },
        filemanager_title: "BlogEngine File Manager",

        //setup: function (e) {
        //    e.onInit.add(function (ed) {
        //        alert("after initialization");
        //    });
        //}
    });
}

//save post data
function savePostData() {
    debugger;
    var _postslug = "";
    var postTags = [];

    if ($.trim($("#PostUrlSlug").val()) != null && $.trim($("#PostUrlSlug").val()) != "") {
        _postslug = $.trim($("#PostUrlSlug").val());
    }
    else {
        var _postslug = $.trim($("#txtPostTitle").val());
        _postslug = _postslug.replace(/\ /g, '-'); //regular expression to replace space with '-'
    }
    $.each($("#ddlTags option:selected"), function () {
        postTags.push({ TagId: $(this).val() });
    });

    var postBody = tinyMCE.activeEditor.getContent();

    var postData = {
        PostId: $("#hdnPostId").val(),
        Title: $("#txtPostTitle").val().trim(),
        PostDescription: postBody,
        PostUrlSlug: _postslug,
        postStatus: 101, //for publish
        PostMeta: $("#txtSearchDescription").val(),
        CategoryId: $("input[name='rdlPostCategories']:checked").val(),
        Tags: postTags
    };

    $.ajax({
        url: 'NewPost',
        method: 'POST',
        datatype: 'json',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(postData),
        success: function (data) {
            debugger;
            if (data.IsSucess == true)
                alert("post data updated successfully");
        },
        error: function () {
            debugger;
            alert("post updation failed");
            console.log("post updation failed");
        }
    });

}



