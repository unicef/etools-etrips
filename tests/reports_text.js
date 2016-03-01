describe('Reports - Text', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';
    var progressReportLoremText = faker.lorem.paragraph(1);
    var constraintsLoremText = faker.lorem.paragraph(1);
    var lessonLearnedLoremText = faker.lorem.paragraph(1);
    var opportunitiesLoremText = faker.lorem.paragraph(1);

    it('should be able to login and select the My Trips tab and the Report button', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();

        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();
    });

    it('should have 4 textareas', function() {
        waitForElement('button.button-calm');
        element(by.buttonText('Report')).click();
        element.all(by.css('textarea')).count().should.eventually.equal(4);
    });

    it('should be able to enter text in each textarea and submit', function() {
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).clear().sendKeys(progressReportLoremText);
        textareas.get(1).clear().sendKeys(constraintsLoremText);
        textareas.get(2).clear().sendKeys(lessonLearnedLoremText);
        textareas.get(3).clear().sendKeys(opportunitiesLoremText);
        element(by.buttonText('Submit Report')).click();

        browser.wait(function() {
            return element(by.buttonText('Complete Trip')).isPresent();
        }, 2000);
    });

    it('should be see a popup dialogue and a Complete Trip button', function() {
        waitForElement('div.popup-container.popup-showing.active');

        browser.wait(function() {
            return element(by.buttonText('Complete Trip')).isPresent();
        }, 2000);
    });

    it('should be see the entered report text', function() {
        this.timeout(20000);

        // logout
        element(by.buttonText('OK')).click();        
        element(by.cssContainingText('.button.back-button', 'My Trips')).click();
        waitForElement('ion-view[view-title="My Trips"] ion-item.item-avatar');        
        element(by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon')).click();
        element(by.cssContainingText('.item', 'Logout')).click();

        // login and go to report text tab
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();
        waitForElement('button.button-calm');
        element(by.buttonText('Report')).click();

        // validate entered text
        var textareas = element.all(by.css('textarea'));
        textareas.get(0).getAttribute('value').should.eventually.be.equal(progressReportLoremText);
        textareas.get(1).getAttribute('value').should.eventually.be.equal(constraintsLoremText);
        textareas.get(2).getAttribute('value').should.eventually.be.equal(lessonLearnedLoremText);
        textareas.get(3).getAttribute('value').should.eventually.be.equal(opportunitiesLoremText);
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});