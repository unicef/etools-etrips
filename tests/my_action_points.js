describe('My Trips', function() {
    var allActionPointsCssSelector = 'ion-view[view-title="My Action Points"] ion-item';
    var actionsTaken = faker.lorem.paragraphs(1, ' ').replace(/\s+/g, ' ').trim();

    it('should be able to login and select the My Action Points tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(2).click();
    });

    it('should have the correct number of action points', function() {
        element.all(by.css(allActionPointsCssSelector)).count().should.eventually.equal(1);
    });

    it('should be able to tap an action point, see the action point details, submit the action point, and see the updated action point status', function() {
        this.timeout(20000);

        var actionPoints = element.all(by.css(allActionPointsCssSelector));
        var actionPoint = actionPoints.get(0);

        // verify action point status (planned)
        actionPoint.element(by.css('.status')).getText().should.eventually.equal('Open');

        // tap action point
        browser.actions()
                 .mouseMove(actionPoint)
                 .mouseDown()
                 .mouseUp()
                 .perform();

        // view action point, change actions taken, completed date and submit
        waitForElement('button.button-calm');
        element(by.css('textarea:not([disabled])')).clear();
        element(by.css('textarea:not([disabled])')).sendKeys(actionsTaken);
        element.all(by.css('option[label="25"]')).get(1).click();
        element.all(by.cssContainingText('option', 'Dec')).get(1).click();
        element.all(by.cssContainingText('option', '2017')).get(1).click();
        element(by.buttonText('Submit')).click();

        // return to my action points, click OK to submit
        waitForElement('div.popup-container.popup-showing.active', 20000);
        element(by.buttonText('OK')).click();

        // validate actions taken and completed date
        actionPoint.element(by.css('.actions_taken')).getText().should.eventually.equal(actionsTaken);
        actionPoint.element(by.css('.completed_date')).getText().should.eventually.equal('25/12/2017');
    });

    it('should be able to logout', function() {
        element(by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon')).click();
        element(by.cssContainingText('.item', 'Logout')).click();
        element(by.css('input[type="email"]')).clear();
    });
});