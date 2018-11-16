require 'eyes_selenium'
require 'selenium-webdriver'

# Initialize the eyes SDK and set your private API key.
eyes = Applitools::Selenium::Eyes.new
eyes.api_key = 'd1hQAwqXH04jtJ5wGIej01whl1108x4xRPK3SvsmXP3fA110'

# Open a Chrome Browser.
driver = Selenium::WebDriver.for :chrome

begin
  # Start the test and set the browser's viewport size to 800x600.
  # vps = {width:900, height:600}
  # vps = {width:1823, height:583}
  vps = {width:1823, height:700}
  eyes.test(app_name: 'Lux Home Page1e!', test_name: 'Lux Home Page1e!',
            viewport_size: vps, driver: driver) do
    driver.get 'https://members.luxresearchinc.com'

    # Visual checkpoint #1.
    eyes.check_window 'Home Page!'
  end
ensure
  # Close the browser.
  driver.quit

  # If the test was aborted before eyes.close was called, ends the test as aborted.
  eyes.abort_if_not_closed
end




# function dw_getWindowDims() {
#     var doc = document, w = window;
#     var docEl = (doc.compatMode && doc.compatMode === 'CSS1Compat')?
#             doc.documentElement: doc.body;
#
#     var width = docEl.clientWidth;
#     var height = docEl.clientHeight;
#
#     // mobile zoomed in?
#     if ( w.innerWidth && width > w.innerWidth ) {
#         width = w.innerWidth;
#         height = w.innerHeight;
#     }
#
#     return {width: width, height: height};
# }
