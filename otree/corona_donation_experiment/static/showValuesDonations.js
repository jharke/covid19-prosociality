function decimalDigits(x) {
    return (Math.round(x * 100) / 100).toFixed(2);
}

function updateFields() {
    let donation = decimalDigits($('#donation').val());
    let keepValue = decimalDigits(1 - $('#donation').val());
    $('#valueCharity').text('£ ' + donation);
    $('#valueOwn').text('£ ' + keepValue);
}

function initRandom() {
    const initDonation = Math.random();
    $('#donation').val(initDonation);
    $('#id_initial_donation').val(initDonation);
}

initRandom();

$('#donation').on('input', function () {
    updateFields();
});
