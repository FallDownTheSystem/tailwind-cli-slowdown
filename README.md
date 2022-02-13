# Tailwind CSS CLI slowdown reproduction

1. `npm install`
2. `npm run watch`
3. Spam save ./folder/noonroot.aspx or ./folder/nonroot2.aspx (On Windows you can hold down ctrl + save to rapidly save the file)
4. Spam save ./root.aspx for a long while
5. Try to spam save one of the nonroot.aspx files again

The CLI now gets "stuck" on adding the rebuild step to the promise chain faster than it can process then, making the chain longer and longer. Once you stop spamming save, the chain will unwind and all the rebuilds will complete. But now each time you attempt to save, the process allocates a larger chunk of memory than originally.

This is even more evident if you spam save the tailwind.config.js file. This takes even longer, and seems to reserve much more memory.

After a while, the memory will be released, but subsequent saves of the noonroot.aspx files will cause much larger chunks of memory to be allocated, and the built times have increased by an order of magnitude.

At the extreme, this will lead to an out-of-memory exception and the node process will crash.

This bug seems to only happen when you edit one of the files in the root folder, and is more evident on larger projects where the building times are longer to begin with, and thus the memory 'leak' becomes more apparent faster.

This is harder to reproduce, but from experience, I would argue that this memory 'leak' happens often when you attempt to save a file while the rebuild is still in process. In a larger project, my watcher node process will crash several times a day due to out-of-memory exceptions.

The repository also includes a modified-cli.js that I used for debugging purposes. The modified Tailwind CLI has the addition of logging when the watcher runs the on change handler, and when the promise chain is increased or decreased.
