# Preview Async API
- This will preview AsyncAPI yaml files in the browser using the AsyncAPI preview cli.
- This is just a wrapper around [asyncapi/cli](https://www.asyncapi.com/docs/tools/cli/installation)
that lets you open the preview in your default browser.
- I haven't added much to this, and I'm the only person using it currently. Feel
free to submit any pull/feature requests if you think of something you want or
if you notice any bugs.

## Install
- You must have [npm and node](https://nodejs.org/en/download) installed on your
system.
- add to your lazy config:
    ```lua
    { 'MikeWelsh801/AsyncAPIPreview.nvim', opts = {} }
    ```
## Default options

```lua
{
    port = 4001,
    ip = "localhost"
}
```

## Usage

User commands (must be in an AsyncAPI directory):
```lua
PreviewAsync

ReloadAsync
```



