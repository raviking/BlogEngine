
$(function () {    

    //initilizing tinyMCE editor
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
        menubar:false,
        toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link unlink anchor styleselect | responsivefilemanager charmap",
        toolbar2: "image media | forecolor backcolor  | print preview code paste table | hr anchor pagebreak visualblocks insertdatetime visualchars searchreplace | fullscreen",
        image_advtab: true,
        relative_urls : false,
        remove_script_host : false,
        document_base_url: HostAddress,
        media_live_embeds: true,
        paste_data_images: true,
        paste_as_text: true,
        plugin_preview_height: 550,
        plugin_preview_width: 1300,
        code_dialog_height: 550,
        code_dialog_width: 1000,
        wordcount_cleanregex: /[0-9.(),;:!?%#$?\x27\x22_+=\\\/\-]*/g,
        external_filemanager_path: HostAddress+"/filemanager/",
        external_plugins: { "filemanager": HostAddress+"/filemanager/plugin.min.js" },
        filemanager_title: "BlogEngine File Manager"
    });
});

//save post data
function savePostData() {
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
        PostId:0,
        Title: $("#txtPostTitle").val().trim(),
        PostDescription: postBody,
        PostUrlSlug: _postslug,
        postStatus:101, //for publish
        PostMeta: $("#txtSearchDescription").val(),
        CategoryId: $("input[name='rdlPostCategories']:checked").val(),
        Tags: postTags        
    };

    $.ajax({
        url: 'NewPost',
        method: 'POST',
        datatype: 'json',
        contentType: "application/json; charset=utf-8",
        data:JSON.stringify(postData),
        success: function (data) {
            debugger;
            if (data.IsSucess==true)
                alert("Post data saved!");
        },
        error: function () {
            alert("Post saving failed pls try again!");
        }
    });
 
}


    
