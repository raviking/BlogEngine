
$(function () {    

    //initilizing tinyMCE editor
    tinymce.init({
        selector: 'textarea',
        plugins: [
        "advlist autolink lists link image charmap print preview anchor",
        "searchreplace visualblocks code fullpage",
        "insertdatetime media table contextmenu paste autoresize hr searchreplace",
        "wordcount codesample"
        ],
        codesample_languages: [
        { text: 'HTML/XML', value: 'markup' },
        { text: 'JavaScript', value: 'javascript' },
        { text: 'CSS', value: 'css' },
        { text: 'PHP', value: 'php' },
        { text: 'Ruby', value: 'ruby' },
        { text: 'Python', value: 'python' },
        { text: 'Java', value: 'java' },
        { text: 'C', value: 'c' },
        { text: 'C#', value: 'csharp' },
        { text: 'C++', value: 'cpp' }
        ],
        min_height: 400,
        toolbar: "insertfile undo redo | styleselect | bold italic paste | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | preview fullpage code",
        //resize: 'both',       
        //fullpage_default_fontsize: "14px",
        //fullpage_default_font_family: "'Times New Roman', Georgia, Serif;"
        fullpage_default_langcode: "en-US",
        //fullpage_default_text_color: "blue"
        //fullpage_hide_in_source_view: true
        autoresize_max_height: 1000,
        media_live_embeds: true,
        paste_data_images: true,
        paste_as_text: true,
        plugin_preview_height: 550,
        plugin_preview_width: 1300,
        code_dialog_height: 550,
        code_dialog_width: 1000,
        wordcount_cleanregex: /[0-9.(),;:!?%#$?\x27\x22_+=\\\/\-]*/g
    });
   
});

$(document).ready(function () {
    //Choosen dropdowns initialization
    $("#ddlCategories").chosen();
    //$("#ddlTags").choosen();
});
    
