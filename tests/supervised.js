describe('Supervised', function() {
    var allTripsCssSelector = 'ion-view[view-title="Supervised"] ion-item.item-avatar';

    it('should be able to login and select the Supervised tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(1).click();
    });

    it('should have the correct number of trips', function() {    
        element.all(by.css(allTripsCssSelector)).count().should.eventually.equal(2);
    });

    it('should be able to pull to refresh', function() {
        element(by.css('ion-view[view-title="Supervised"] div.scroll-refresher.invisible')).isPresent().should.eventually.true;

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

        element(by.css('ion-view[view-title="Supervised"] div.scroll-refresher')).getAttribute('class').then(function(val){
            browser.sleep(500);
            val.should.equal('scroll-refresher js-scrolling invisible');            
            element(by.css('div.scroll-refresher.invisible')).isPresent().should.eventually.true;
        });
    });

    it('should be able to tap a trip, see the trip details, submit the trip, and see the updated trip status', function() {        
        this.timeout(20000);

        var trips = element.all(by.css(allTripsCssSelector));
        var trip = trips.get(1);

        // verify trip status (submitted)        
        trip.element(by.css('i.ion-android-done')).isPresent().should.eventually.true;

        // tap trip
        browser.actions()
                 .mouseMove(trip)
                 .mouseDown()
                 .mouseUp()
                 .perform();


        // view trip and submit
        waitForElement('button.button-balanced');
        element(by.buttonText('Approve')).click();

        // return to trip listing, click OK to submit
        waitForElement('div.popup-container.popup-showing.active', 20000);
        element(by.buttonText('OK')).click();

        // refresh list
        browser.actions()
                .mouseMove(trips.get(0))
                .mouseDown()
                .mouseMove(trips.get(0), { x:0, y:0 })
                .mouseMove(trips.get(1))
                .mouseUp()
                .perform();

        browser.sleep(3000);

        // validate icon (approved)
        trip.element(by.css('ion-view[view-title="Supervised"] i.ion-android-done-all')).isPresent().should.eventually.true;        
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});