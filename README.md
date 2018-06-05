# Puppeteer Lambda Starter Kit

Starter Kit for running Headless-Chrome by [Puppeteer](https://github.com/GoogleChrome/puppeteer) on Aliyun Lambda.

It can use alone and also supported [Serverless Framework](https://github.com/serverless/serverless).

## Download

```
$ git clone -o starter-kit https://github.com/muxiangqiu/puppeteer-lambda-starter-kit.git your_project_name
```

## Run on local

By executing `SLOWMO_MS=250 npm run local`, you can check the operation while actually viewing the chrome (non-headless, slowmo).

### chrome in package (recommended)

If you use alone, run `npm run package`, and deploy the package.zip. 

If you use with Serverless, run `serverless deploy` (this runs `npm run package` when packaging).

### chrome NOT in package

Due to the large size of Chrome, it may exceed the [Lambda package size limit](https://help.aliyun.com/document_detail/51907.html?spm=a2c4g.11174283.6.584.kRT7h3) (50MB) depending on the other module to include. 
In that case, put Chrome in OSS and download it at container startup so startup time will be longer.

Run `npm run package-nochrome`, deploy the package.zip, and set following env valiables on Lambda.

- `CHROME_BUCKET`(required): OSS bucket where Chrome is put
- `CHROME_REGION`(required): OSS region where Chrome is put
- `CHROME_KEY`(optional): OSS key. default: `headless_shell.tar.gz`



## Build Headless-Chrome (optional)

This kit includes Chrome built by myself because official build Chrome installed by Puppeteer has problems about running on Lambda (missing shared library etc.).

If you want to use latest chrome, run chrome/buildChrome.sh on fcli sbox having at least 16GB memory and 30GB volume. 
See also [serverless-chrome](https://github.com/adieuadieu/serverless-chrome/blob/master/docs/chrome.md).
Once you build it, link to `headless_shell.tar.gz` in `chrome` dir.

## Reference

[https://github.com/sambaiz/puppeteer-lambda-starter-kit](https://github.com/sambaiz/puppeteer-lambda-starter-kit)
