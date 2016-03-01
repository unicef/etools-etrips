describe('Reports - Action Points', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';

    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should be able select the first Trip, click on Report, click on Action tab item, and create new Action Point ', function() {        
        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();
        waitForElement('button.button-calm');

        element(by.buttonText('Report')).click();
        waitForElement('a.tab-item-active > i.icon.ion-document-text');

        element(by.linkText('Actions')).click();
        waitForElement('a.button.button-positive');

        element(by.linkText('New Action Point')).click();
        waitForElement('div.title.title-center.header-item');
    });

    var description = faker.lorem.paragraphs(1, ' ').replace(/\s+/g, ' ').trim();
    var comments = faker.lorem.paragraphs(1, ' ').replace(/\s+/g, ' ').trim();

    it('should be able enter action point data and save', function(){
        this.timeout(30000);
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).sendKeys(description);
        textareas.get(1).sendKeys(comments);
        element(by.cssContainingText('option', 'finn')).click();        
        element(by.css('option[label="03"]')).click();   
        element(by.cssContainingText('option', 'Jan')).click();   
        element(by.cssContainingText('option', '2017')).click();   
        element(by.buttonText('Submit')).click();

        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
    });

    it('should be able have a list of the newly created action point ', function(){   
        // validate number of action points        
        element.all(by.css('ion-view[nav-view="active"] a.item-content')).count().should.eventually.equal(1);

        // validate new action point
        element(by.cssContainingText('ion-view[nav-view="active"] a.item-content h2', 'finn')).isPresent().should.eventually.be.true;        
        
        var data = element.all(by.css('ion-view[nav-view="active"] a.item-content p'));
        data.get(0).getText().should.eventually.equal('Status: open');
        data.get(1).getText().should.eventually.equal(description.substring(0, 254));
        data.get(2).getText().should.eventually.equal('Due by: Jan 3, 2017');
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});