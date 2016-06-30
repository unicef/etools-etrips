describe('Reports - Text', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';
    var progressReportLoremText = faker.lorem.paragraph(1);
    var constraintsLoremText = faker.lorem.paragraph(1);
    var lessonLearnedLoremText = faker.lorem.paragraph(1);
    var opportunitiesLoremText = faker.lorem.paragraph(1);

    var progressReportAutosaveLoremText = faker.lorem.paragraph(1);
    var constraintsAutosaveLoremText = faker.lorem.paragraph(1);
    var lessonLearnedAutosaveLoremText = faker.lorem.paragraph(1);
    var opportunitiesAutosaveLoremText = faker.lorem.paragraph(1);

    it('should be able to login and select the My Trips tab and the Report button', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();

        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();
    });

    it('should have 4 textareas', function() {
        waitForElement('button.button-calm');                
        element(by.buttonText('Report')).click();
        
        waitForElement('button#report_text');
        element(by.buttonText('Text Reporting')).click();

        element.all(by.css('textarea')).count().should.eventually.equal(4);
    });

    it('should be able to enter text in each textarea and the values be autosaved', function() {
        this.timeout(15000);
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).clear().sendKeys(progressReportAutosaveLoremText);
        textareas.get(1).clear().sendKeys(constraintsAutosaveLoremText);
        textareas.get(2).clear().sendKeys(lessonLearnedAutosaveLoremText);
        textareas.get(3).clear().sendKeys(opportunitiesAutosaveLoremText);        

        element(by.linkText('My Trips')).click();
        auth.logout();
        auth.login();

        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click(); 

        element(by.buttonText('Report')).click();
        waitForElement('button#report_text');
        element(by.buttonText('Text Reporting')).click();
        waitForElement('textarea');

        var textareas = element.all(by.css('textarea'));
        textareas.get(0).getAttribute('value').should.eventually.be.equal(progressReportAutosaveLoremText);
        textareas.get(1).getAttribute('value').should.eventually.be.equal(constraintsAutosaveLoremText);
        textareas.get(2).getAttribute('value').should.eventually.be.equal(lessonLearnedAutosaveLoremText);
        textareas.get(3).getAttribute('value').should.eventually.be.equal(opportunitiesAutosaveLoremText);
    });

    it('should be able to enter text in each textarea and submit', function() {
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).clear().sendKeys(progressReportLoremText);
        textareas.get(1).clear().sendKeys(constraintsLoremText);
        textareas.get(2).clear().sendKeys(lessonLearnedLoremText);
        textareas.get(3).clear().sendKeys(opportunitiesLoremText);
        element(by.buttonText('Submit Report')).click();
    });

    it('should be see a popup dialogue and a Complete Trip button', function() {
        waitForElement('button.button-positive');
        element(by.buttonText('OK')).click();

        element.all(by.css('button.back-button:not(.hide)')).get(1).click();
        waitForElement('button.back-button:not(.hide)');
        element(by.buttonText('Complete Trip')).isPresent();
    });

    it('should be see the entered report text', function() {
        this.timeout(15000);
        element(by.linkText('My Trips')).click();        
        auth.logout();
        auth.login();

        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click(); 

        element(by.buttonText('Report')).click();
        waitForElement('button#report_text');
        element(by.buttonText('Text Reporting')).click();
        waitForElement('textarea');

        // validate entered text
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).getAttribute('value').should.eventually.be.equal(progressReportLoremText);
        textareas.get(1).getAttribute('value').should.eventually.be.equal(constraintsLoremText);
        textareas.get(2).getAttribute('value').should.eventually.be.equal(lessonLearnedLoremText);
        textareas.get(3).getAttribute('value').should.eventually.be.equal(opportunitiesLoremText);
    });

    it('should be able to logout', function() {
        element.all(by.css('button.back-button:not(.hide)')).get(0).click();
        waitForElement('button.back-button:not(.hide)');

        element.all(by.css('button.back-button:not(.hide)')).get(1).click();
        waitForElement('button.back-button:not(.hide)');
        
        element.all(by.css('button.back-button:not(.hide)')).get(0).click();
        waitForElement('button[menu-toggle="left"]:not(.hide)');
        auth.logout();
    });
});