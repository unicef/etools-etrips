describe('Sidebar Menu', function() {
    var tabs = ['My Trips', 'Supervised'];
    var sideMenuButton = by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon');

    it('should be able to login', function() {
        auth.login();
    });

    it('should be displayed when the sidemenu bar is clicked', function() {
        element(sideMenuButton).click();
        waitForElement('h1');

        element(by.css('body')).getAttribute('class').then(function(val){
            _.includes(val.split(' '), 'menu-open').should.equal.true;
        });

        element(by.css('h1')).getText().should.eventually.equal('eTrip Menu');
        element(by.css('ion-item.item-divider')).getText().should.eventually.equal('Country: hoth');
        element.all(by.css('ion-side-menu ion-item.item-complex')).count().should.eventually.equal(2);       
    });

    it('should display the Trips tab when the Trips link is clicked', function() {
        element(sideMenuButton).click();
        element.all(by.css('a.tab-item')).get(1).click();
        element(sideMenuButton).click();
        element(by.linkText('Trips')).click();
        element(by.css('div[nav-bar="active"] > ion-header-bar > div.title')).getText().should.eventually.equal('My Trips');
    });

    it('should display the Settings view', function() {
        element(sideMenuButton).click();
        element(by.linkText('Settings')).click();
        element(by.css('ion-view[view-title="Settings"] h2')).getText().should.eventually.equal('Connection');
        element(by.css('ion-view[view-title="Settings"] h2')).click();

        element.all(by.css('label.item-radio')).count().should.eventually.equal(3);
        element.all(by.css('button[disabled="disabled"]')).count().should.eventually.equal(1);
        element(by.css('input[type="text"]')).sendKeys('c345');
        element.all(by.css('button[disabled="disabled"]')).count().should.eventually.equal(0);

        element(by.css('div[nav-bar="active"] button.back-button')).click();
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