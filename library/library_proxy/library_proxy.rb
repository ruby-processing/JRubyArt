java_import Java::MonkstoneCore::LibraryProxy
java_import Java::ProcessingEvent::KeyEvent
java_import Java::ProcessingEvent::MouseEvent

# classes that inherit from LibraryProxy are expected to implement
# the abstract draw method of monkstone.core.LibraryProxy the other methods are
# registered with PApplet instance in constructor ImplementingClass.new(app)
#
# def pre... NOOP can be overridden
# def draw... Abstract Method should be implemented NOOP is OK
# def post... NOOP can be overridden
# def keyEvent(e)... NOOP can be overridden
# def mouseEvent(e)... NOOP can be overridden
# `app` can be called to get PApplet instance
