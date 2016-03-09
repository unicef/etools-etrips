describe('Reports - Drafts', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';
    var progressReportLoremText = faker.lorem.paragraph(1);
    var constraintsLoremText = faker.lorem.paragraph(1);
    var lessonLearnedLoremText = faker.lorem.paragraph(1);
    var opportunitiesLoremText = faker.lorem.paragraph(1);

    it('should be able to login and select the My Trips tab, Report button and go to Draft tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();

        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();
    });

    it('should have 4 textareas', function() {
        waitForElement('button.button-calm');
        element(by.buttonText('Report')).click();
        element(by.linkText('Drafts')).click();
        element.all(by.css('textarea')).count().should.eventually.equal(4);
    });

    it('should be able to enter text in each textarea and click on Save Drafts', function() {
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).clear().sendKeys(progressReportLoremText);
        textareas.get(1).clear().sendKeys(constraintsLoremText);
        textareas.get(2).clear().sendKeys(lessonLearnedLoremText);
        textareas.get(3).clear().sendKeys(opportunitiesLoremText);
        element(by.buttonText('Save Drafts')).click();
        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
    });

    it('should be able Undo Current Changes', function() {
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).clear();
        textareas.get(1).clear();
        textareas.get(2).clear();
        textareas.get(3).clear();
        element(by.buttonText('Undo Current Changes')).click();
        
        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();

        textareas.get(0).getAttribute('value').should.eventually.be.equal(progressReportLoremText);
        textareas.get(1).getAttribute('value').should.eventually.be.equal(constraintsLoremText);
        textareas.get(2).getAttribute('value').should.eventually.be.equal(lessonLearnedLoremText);
        textareas.get(3).getAttribute('value').should.eventually.be.equal(opportunitiesLoremText);
    });

    it('should be able Replace Drafts with Current Report', function() {
        var textareas = element.all(by.css('textarea'));
        element(by.buttonText('Replace Drafts With Current Report')).click();
        browser.sleep(1000);
        textareas.get(1).getAttribute('value').should.eventually.be.equal('');
        textareas.get(2).getAttribute('value').should.eventually.be.equal('');
        textareas.get(3).getAttribute('value').should.eventually.be.equal('');
    });

    it('should have two buttons disabled if Danger Zone option not selected', function() {       
        element(by.buttonText('Send As Official Report')).getAttribute('disabled').should.eventually.equal('true');
        element(by.buttonText('Discard Drafts')).getAttribute('disabled').should.eventually.equal('true');
    });

    it('should have two buttons enabled if Danger Zone enabled', function() {
        var textareas = element.all(by.css('textarea'));
        var el = element(by.css('div.item.item-toggle.toggle-large.ng-valid > label'));
        
        browser.actions()
                .mouseMove(el)
                .mouseDown(el)
                .mouseUp(el)
                .perform();
          
        element(by.buttonText('Send As Official Report')).getAttribute('disabled').should.eventually.equal(null);
        element(by.buttonText('Discard Drafts')).getAttribute('disabled').should.eventually.equal(null);
        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
    });

    it('should be able to click on Discard Drafts button', function() {
        var textareas = element.all(by.css('textarea'));
        textareas.get(1).clear().sendKeys(constraintsLoremText);
        textareas.get(2).clear().sendKeys(lessonLearnedLoremText);
        textareas.get(3).clear().sendKeys(opportunitiesLoremText);
        element(by.buttonText('Discard Drafts')).click();

        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
        textareas.get(1).getAttribute('value').should.eventually.be.equal('');
        textareas.get(2).getAttribute('value').should.eventually.be.equal('');
        textareas.get(3).getAttribute('value').should.eventually.be.equal('');
    });

    it('should be able to click on Send As Official Report button', function() {         
        element(by.buttonText('Send As Official Report')).click();
        waitForElement('div.popup-container.popup-showing.active');
        element(by.buttonText('OK')).click();
        element.all(by.css(allTripsCssSelector)).count().should.eventually.equal(3);
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});