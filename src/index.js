const setup = require('./starter-kit/setup');
const fs = require('fs');

exports.handler = async (event, context, callback) => {
  const browser = await setup.getBrowser(context);
  exports.run(browser).then(
    (result) => callback(null, fs.readFileSync('/tmp/screenshot.png'))
  ).catch(
    (err) => callback(err)
  );
};

exports.run = async (browser) => {
  // implement here
  // this is sample
  const page = await browser.newPage();
  await page.goto('https://fc.console.aliyun.com');
  await page.screenshot({
    path: '/tmp/screenshot.png',
    clip: {
      x: 200,
      y: 60,
      width: 780,
      height: 450,
    },
  });
  return 'done';
};
