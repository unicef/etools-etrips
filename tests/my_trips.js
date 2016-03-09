describe('My Trips', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';

    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should have the correct number of trips', function() {    
        element.all(by.css(allTripsCssSelector)).count().should.eventually.equal(3);
    });

    it('should be able to pull to refresh', function() {
        element(by.css('ion-view[view-title="My Trips"] div.scroll-refresher.invisible')).isPresent().should.eventually.true;

        var trips = element.all(by.css(allTripsCssSelector));

        var startPoint = trips.get(0);
        var endPoint = trips.get(1);

        browser.actions()
                .mouseMove(startPoint)
                .mouseDown()
                .mouseMove(startPoint, { x:0, y:0 })
                .mouseMove(endPoint)
                .mouseUp()
                .perform();

        element(by.css('ion-view[view-title="My Trips"] div.scroll-refresher')).getAttribute('class').then(function(val){
            browser.sleep(500);
            val.indexOf('scroll-refresher js-scrolling').should.be.greaterThan(-1);        
            element(by.css('div.scroll-refresher.invisible')).isPresent().should.eventually.true;
        });
    });

    it('should be able to tap a trip, see the trip details, submit the trip, and see the updated trip status', function() {
        this.timeout(20000);

        var trips = element.all(by.css(allTripsCssSelector));
        var trip = trips.get(2);

        // verify trip status (planned)        
        trip.element(by.css('i.ion-android-checkbox-outline-blank')).isPresent().should.eventually.true;

        // tap trip
        browser.actions()
                 .mouseMove(trip)
                 .mouseDown()
                 .mouseUp()
                 .perform();


        // view trip and submit
        waitForElement('button.button-calm');
        element(by.buttonText('Submit')).click();

        // return to trip listing, click OK to submit
        waitForElement('div.popup-container.popup-showing.active', 20000);
        element(by.buttonText('OK')).click();

        // refresh list
        browser.actions()
                .mouseMove(trips.get(0))
                .mouseDown()
                .mouseMove(trips.get(0), { x:0, y:0 })
                .mouseMove(trips.get(2))
                .mouseUp()
                .perform();

        // validate icon
        trip.element(by.css('i.ion-android-done')).isPresent().should.eventually.true;
    });

    it('should be able to logout', function() {
        element(by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon')).click();
        element(by.cssContainingText('.item', 'Logout')).click();        
        element(by.css('input[type="email"]')).clear();
    });
});