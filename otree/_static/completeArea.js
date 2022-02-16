const autoCompletejs = new autoComplete({
    data: {
        src: async function () {
            // Loading placeholder text
            document
                .querySelector('#id_qLocationInput')
                .setAttribute('placeholder', 'Loading...');
            // Fetch External Data Source
            const source = await fetch('/static/locations.json');
            const data = await source.json();
            // Returns Fetched data
            return data;
        },
        // keys in json: 'sameZipArea', 'area', 'zip', 'areaZip', 'areaSame'
        key: ['zip', 'area', 'sameZipArea'],
        cache: true,
    },
    sort: function (a, b) {
        if (a.index < b.index) {
            return -1;
        }
        if (a.index > b.index) {
            return 1;
        }
        return 0;
    },
    placeHolder: 'First part of postcode, name of area, ...',
    selector: '#id_qLocationInput',
    debounce: 50,
    searchEngine: 'strict',
    highlight: true,
    maxResults: 100,
    resultsList: {
        render: true,
        container: function (source) {
            source.setAttribute('id', 'id_qLocationInput_list');
            source.setAttribute('class', 'autoComplete_selected');
        },
        element: 'ul',
        destination: document.querySelector('#id_qLocationInput'),
        position: 'afterend',
    },
    resultItem: {
        content: function (data, source) {
            if (data.key == 'zip') {
                source.innerHTML = data.value.areaZip + ' (' + data.match + ')';
            } else if (data.key == 'area') {
                source.innerHTML = data.match;
            } else if (data.key == 'sameZipArea') {
                source.innerHTML = data.value.areaSame;
            } else {
                source.innerHTML = data.match;
            }
        },
        element: 'li',
    },
    noResults: function () {
        const result = document.createElement('li');
        result.setAttribute('class', 'no_result');
        result.setAttribute('tabindex', '1');
        result.innerHTML =
            'No results, you can also click the link below to manually enter your postcode, county, or district.';
        document.querySelector('#id_qLocationInput_list').appendChild(result);
    },
    onSelection: function (feedback) {
        let selection;
        if (feedback.selection.key == 'area') {
            selection = feedback.selection.value.area;
        } else if (feedback.selection.key == 'zip') {
            selection = feedback.selection.value.areaZip;
        } else if (feedback.selection.key == 'sameZipArea') {
            selection = feedback.selection.value.areaSame;
        }
        // Render selected choice to input
        document.querySelector('#id_qLocation').value = selection;
        const locSel = document.querySelector('#location-selection');
        locSel.innerHTML =
            '<b>The area you selected is:</b><br>' +
            document.querySelector('#id_qLocation').value;
        document.querySelector('#location-selection').style.display = 'block';
        // Clear Input
        document.querySelector('#id_qLocationInput').value = '';
    },
});
