## Overview

This little utility allows you to delay a callback until the nextframe, byFrames or byTime

### Next Frame Delay
```
Delay.nextFrame(() -> {
	// trigger on next frame
});
```

### Frame Delay

Delay callback function by 5 of frames.

```
Delay.byFrames(5, () -> {
	// triggers after 5 frames
});
```

### Time Delay

Delay callback function by 2 seconds.

```
Delay.byTime(2, () -> {
	// triggers after 2 seconds
});
```

The default time unit is seconds, however this can be changed by settings the last argument to one of the following options:


```
TimeUnit.MILLISECONDS
TimeUnit.SECONDS
TimeUnit.MINUTES
TimeUnit.HOURS
TimeUnit.DAYS
```

eg: 

```
Delay.byTime(2, () -> {
	// triggers after 2 minutes
}, TimeUnit.MINUTES);
```


### Passing Argument

Delay callback function until the next frame and pass parameters.

```
Delay.nextFrame((value:int, str:String) -> {
	// trigger on next frame with params
}, [1, "test"]);
}
```

Delay callback function by X number of frames and pass parameters.

```
Delay.byFrames(5, (value:int, str:String) -> {
	// triggers after 5 frames
}, [1, "test"]);
```

Delay callback function by X amount of time pass parameters.

```
Delay.byTime(200, (value:int, str:String) -> {
	// triggers after 200 milliseconds
}, [1, "test"], TimeUnit.MILLISECONDS);```

