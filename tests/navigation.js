describe('Navigation', function() {
    var tabs = ['My Trips', 'Supervised'];

    it('should be able to login', function() {
        auth.login();
    });

    it('should have several tabs correctly labeled', function(){ 
        element.all(by.css('a.tab-item')).count().should.eventually.equal(tabs.length);        

        _.each(tabs, function(tab, tabIndex){
            element.all(by.css('a.tab-item')).get(tabIndex).getText().should.eventually.equal(tab);
        });        
    });

    it('should be able to toggle between the tabs', function(){ 
        _.each(tabs, function(tab, tabIndex){
            var tabBarItem = element.all(by.css('a.tab-item')).get(tabIndex);
            tabBarItem.click();
            tabBarItem.getAttribute('class').then(function(val){                
                _.includes(val.split(' '), 'tab-item-active').should.equal.true;
            });

            element(by.css('div[nav-bar="active"] > ion-header-bar > div.title')).getText().should.eventually.equal(tab);
        });
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