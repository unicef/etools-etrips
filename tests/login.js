describe('Login View', function() {
    var pageLoaded = false;
    var email = faker.internet.email();
    var password = faker.internet.password();
    
    beforeEach(function() {
        if (pageLoaded === false) {
            browser.get(browser.params.url + '/');
            pageLoaded = true;
        }
    });

    it('should have a title, two fields, remember me and a login button', function() {
        this.timeout(4000);

        element.all(by.css('h2')).count().should.eventually.equal(1);
        element.all(by.css('h2')).get(0).getText().should.eventually.equal('eTrips');

        element(by.css('input[type="email"]')).isPresent().should.eventually.true;
        element(by.css('input[type="password"]')).isPresent().should.eventually.true;
        element(by.css('input[type="checkbox"]')).isPresent().should.eventually.true;

        element.all(by.css('button')).count().should.eventually.equal(1);        
        element.all(by.css('button')).get(0).getText().should.eventually.equal('Login');
    });

    it('should have the ability to enter text into the username, password field', function() {        
        element.all(by.model('data')).count().should.eventually.equal(0);

        element(by.css('input[type="email"]')).sendKeys(email);
        element(by.css('input[type="email"]')).getAttribute('value').should.eventually.be.equal(email);
        element(by.model('data.username')).getAttribute('value').should.eventually.be.equal(email);

        element(by.css('input[type="password"]')).sendKeys(password);
        element(by.css('input[type="password"]')).getAttribute('value').should.eventually.be.equal(password);
        element(by.model('data.password')).getAttribute('value').should.eventually.be.equal(password);

        element(by.css('label.toggle')).click();
        element(by.css('input[type="checkbox"]')).isSelected().should.eventually.be.true;
        element(by.model('other.rememberMe')).isSelected().should.eventually.be.true;
    });

    it('should be able to click on login button, get a login failed message and hide the popup message', function() {
        element(by.css('button')).click();
        element(by.css('div.popup')).isPresent().should.eventually.true;
        element(by.css('h3.popup-title')).getText().should.eventually.equal('Login failed!');
        element(by.css('div.popup-body > span')).getText().should.eventually.equal('Please check your credentials!');
        element(by.css('button.button-positive')).click();
        element(by.css('div.popup')).isPresent().should.eventually.false;
    });

    afterEach(function() {
        browser.takeScreenshot().then(function(png) {
            var stream = fs.createWriteStream('./' + path.basename(__filename, '.js') + '_screenshot.png');
            stream.write(new Buffer(png, 'base64'));
            stream.end();
        });        
    });
});