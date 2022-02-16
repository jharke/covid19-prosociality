$('input').on('change', function () {
    if ($(this).is('[type=checkbox]')) {
        if ($(this).is(':checked')) {
            $(this).closest('label').addClass('selected');
        } else {
            $(this).closest('label').removeClass('selected');
        }
    } else if ($(this).is('[type=range]')) {
        $(this).closest('.input-group').addClass('selected');
    } else {
        $(this)
            .closest('.form-group')
            .find('.selected')
            .removeClass('selected');
        $(this).closest('label').addClass('selected');
    }
    return true;
});
$(document).on('wheel', 'input[type=range], input[type=number]', function (e) {
    $(this).blur();
});
$(document).on('keydown', 'input[type=range]', function (e) {
    $(this).blur();
});
