$('select[name^="qCommuteBefore"]').on('change', function () {
    const input1 = $('#id_qCommuteModeBefore').closest('.form-group');
    const input2 = $('#id_qCommuteTimeBefore').closest('.form-group');
    if ($(this).val() != '0') {
        input1.slideDown(800);
        input1.focus();
        input1.find('input').each(function () {
            $(this).attr('required', '');
        });
        input2.slideDown(800);
        input2.focus();
        input2.find('input').each(function () {
            $(this).attr('required', '');
        });
    } else {
        input1.slideUp(800);
        input1.find('input').each(function () {
            $(this).removeAttr('required');
        });
        input2.slideUp(800);
        input2.find('input').each(function () {
            $(this).removeAttr('required');
        });
    }
});

$('select[name^="qCommuteAfter"]').on('change', function () {
    const input1 = $('#id_qCommuteModeAfter').closest('.form-group');
    const input2 = $('#id_qCommuteTimeAfter').closest('.form-group');
    if ($(this).val() != '0') {
        input1.slideDown(800);
        input1.focus();
        input1.find('input').each(function () {
            $(this).attr('required', '');
        });
        input2.slideDown(800);
        input2.focus();
        input2.find('input').each(function () {
            $(this).attr('required', '');
        });
    } else {
        input1.slideUp(800);
        input1.find('input').each(function () {
            $(this).removeAttr('required');
        });
        input2.slideUp(800);
        input2.find('input').each(function () {
            $(this).removeAttr('required');
        });
    }
});
