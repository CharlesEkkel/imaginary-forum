['ready', 'turbolinks:load'].forEach(event => {
    document.addEventListener(event, function() {
        // This is called on the first page load *and* also when the page is changed by turbolinks
        // Ensure that htmx keeps working after turbolink page loads.
        htmx.process(document.body);
        //_hyperscript.processNode(document.body);
    });
});
