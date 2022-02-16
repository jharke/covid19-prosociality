function decimalDigits(x) {
    return (Math.round(x * 100) / 100).toFixed(2);
}

function updateFields() {
    let donation = js_vars.donation;
    let shareGlobal = $('#global_share').val();
    let donationGlobal = decimalDigits(donation * shareGlobal);
    let donationLocal = decimalDigits(donation - donationGlobal);
    $('#valueLocal').text('£ ' + donationLocal);
    $('#valueGlobal').text('£ ' + donationGlobal);
    $('#id_global_donation').val(donationGlobal);
}

function initRandom() {
    const initDonation = Math.random();
    $('#global_share').val(initDonation);
    $('#id_initial_global_share').val(initDonation);
}

initRandom();

$('#global_share').on('input', function () {
    updateFields();
});
