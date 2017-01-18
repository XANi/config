package x

import (
	. "github.com/smartystreets/goconvey/convey"
	"testing"
)

func TestDummy(t *testing.T) {
	Convey("N", t, func() {
		So(nil, ShouldEqual, nil)
	})
}
