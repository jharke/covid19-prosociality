$('input[type="range"]').addClass('required-range');

$('input[type="range"]').on('change click touchend', function () {
    const sel = $(this);
    sel.removeClass('required-range');
    $('.otree-btn-next').prop('disabled', false);
});

$('#form').on('submit', function () {
    const pending = $('.required-range');
    if (pending.length != 0) {
        alert(
            'Please answer all questions! ' +
                '\n' +
                'Use your mouse pointer to move the slider to the desired position.'
        );
        return false;
    } else {
        return true;
    }
});
