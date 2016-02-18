describe('My Trips', function() {
    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should have the correct number of trips', function() {    
        element.all(by.css('ion-view[view-title="My Trips"] ion-item.item-avatar')).count().should.eventually.equal(3);
    });

    it('should be able to pull to refresh', function() {
        element(by.css('ion-view[view-title="My Trips"] div.scroll-refresher.invisible')).isPresent().should.eventually.true;

        var trips = element.all(by.css('ion-view[view-title="My Trips"] ion-item.item-avatar'));

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
            val.should.equal('scroll-refresher js-scrolling invisible');
            browser.sleep(500);
            element(by.css('div.scroll-refresher.invisible')).isPresent().should.eventually.true;
        });
    });

    // it('should be able to swipe left to reveal Report/Submit button', function() {
    //     var trips = element.all(by.css('ion-view[view-title="My Trips"] ion-item.item-avatar'));
    //     var startPoint = trips.get(0);
       
    //     browser.actions()
    //         .dragAndDrop(startPoint, {x: 200, y: 0})
    //         .perform();

    //     browser.sleep(1000);
    // });

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