This is a sample project to reproduce Apple feedback (radar) `FB13544459`.

OS17.2. Xcode 15.2.

- Build the included Xcode project. 
- Run it on an iPad or iPad simulator in landscape orientation. This does not reproduce on an iPhone. 
- Select the row “D” by tapping on it.
- Swipe left on the row to expose the Delete button, and delete the item. (This will delete section BBB).
- Tap on any of the remaining rows in the list (in section AAA)

Expected:
- Row should be selected and its detail view displayed.

Actual:
- Crash.

The problem goes away if the `selection:` parameter in the List is removed. 
Also, this only happens when the *last* section in list goes away. Other sections can go away without the crash happening. 
