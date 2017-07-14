# processTrack

Giving credit where credit due - Loosely adapted from http://hints.macworld.com/article.php?story=2009102906322976

### Usage
Invoke scriptwith three arguments:

- Process name(s) (Must be in quotes if more than one process)
- Number of minutes to run
- Number of samples per minute

### Examples

If you want to sample Safari for 5 minutes with 30 samples per minute
```shell
processTrack.sh Safari 5 30
```

If you want to sample Safari and Chrome for 5 minutes with 30 samples per minute
```shell
processTrack.sh "Safari Chrome" 5 30
```

