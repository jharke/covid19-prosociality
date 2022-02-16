function changeShowHide(element) {
    console.log(element.text());
    if (element.text().includes('Show')) {
        element.closest('.card-header').next('.card-body').collapse('show');
        element.text('Hide');
    } else if (element.text().includes('Hide')) {
        element.closest('.card-header').next('.card-body').collapse('hide');
        element.text('Show');
    }
}
