describe('Notes', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';

    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should be able view the Notes view', function() {        
        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();

        waitForElement('button.button-energized');
        element(by.buttonText('Notes')).click();

        waitForElement('button.button-balanced');
        waitForElement('button.button-assertive');
        element(by.buttonText('Save Notes')).isPresent().should.eventually.true;
        element(by.buttonText('Discard Notes')).isPresent().should.eventually.true;
    });

    it('should be able save a note', function() { 
        this.timeout(20000);

        var trips = element.all(by.css(allTripsCssSelector));
        var sampleNote = faker.lorem.paragraphs(5, ' ').replace(/\s+/g, ' ').trim();

        // save note
        element(by.css('textarea')).sendKeys(sampleNote);
        element(by.buttonText('Save Notes')).click();
        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
        auth.logout();
        
        // validate saved note
        auth.login();
        trips.first().click();
        element(by.buttonText('Notes')).click();
        element(by.css('textarea')).getAttribute('value').then(function(val){
            val.should.equal(sampleNote);
        });
    });
    
    it('should be able discard a saved note', function() { 
        var trips = element.all(by.css(allTripsCssSelector));
        
        // discard note
        element(by.buttonText('Discard Notes')).click();
        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
        auth.logout();
        
        // validate empty note
        auth.login();
        trips.first().click();
        element(by.buttonText('Notes')).click();
        element(by.css('textarea')).getAttribute('value').should.eventually.equal('');
    });

    it('should be able to logout', function() {
        auth.logout();
    });

    afterEach(function() {
        browser.takeScreenshot().then(function(png) {
            var stream = fs.createWriteStream('./' + path.basename(__filename, '.js') + '_screenshot.png');
            stream.write(new Buffer(png, 'base64'));
            stream.end();
        });        
    });
});