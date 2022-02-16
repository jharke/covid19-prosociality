if (js_vars.area) {
    $(' .zip').text(js_vars.area);
}

function numFormat() {
    const val = $(this).val();
    const value = parseInt(val).toLocaleString('en-UK');
    $('#' + $(this).attr('id') + 'Display').text(value);
}

$('#id_qCasesUtlaEstimated').on('input', numFormat);
$('#id_qCasesUkEstimated').on('input', numFormat);
