function setInitValue(q, val) {
    $('#id_' + q).val(val);
    $('#id_' + q + '_value').text(val);
}

setInitValue('qGdpUk', 1.4);
setInitValue('qGdpDeveloping', 3.7);
setInitValue('qPoveryUk', 22);
setInitValue('qPoveryDeveloping', 23);

$('input[type="range"]').on('change input click', function () {
    const sliderValue = $(this).closest('.slider').find('.slider-value');
    const step = $(this).attr('step');
    let value = $(this).val();
    if (step) {
        const stepParts = step.split('.');
        if (stepParts.length > 1) {
            const nDecimal = stepParts[1].length;
            const inputValue = $(this).val();
            value = parseFloat(inputValue).toFixed(nDecimal).toString();
        }
    }
    sliderValue.text(value);
    sliderValue.removeClass('transparent');
});
