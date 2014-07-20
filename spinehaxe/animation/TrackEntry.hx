/******************************************************************************
 * Spine Runtimes Software License
 * Version 2.1
 * 
 * Copyright (c) 2013, Esoteric Software
 * All rights reserved.
 * 
 * You are granted a perpetual, non-exclusive, non-sublicensable and
 * non-transferable license to install, execute and perform the Spine Runtimes
 * Software (the "Software") solely for internal use. Without the written
 * permission of Esoteric Software (typically granted by licensing Spine), you
 * may not (a) modify, translate, adapt or otherwise create derivative works,
 * improvements of the Software or develop new applications using the Software
 * or (b) remove, delete, alter or obscure any trademarks or any copyright,
 * trademark, patent or other intellectual property or proprietary rights
 * notices on or in the Software, including any copy thereof. Redistributions
 * in binary or source form must include this license and terms.
 * 
 * THIS SOFTWARE IS PROVIDED BY ESOTERIC SOFTWARE "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL ESOTERIC SOFTARE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************/
package spinehaxe.animation;

import spinehaxe.Event;
import spinehaxe.Skeleton;
import spinehaxe.animation.Listeners;

class TrackEntry {

	public var next:TrackEntry;
	public var previous:TrackEntry;
	public var animation:Animation;
	public var loop:Bool;
	public var delay:Float;
	public var time:Float = 0;
	public var lastTime:Float = -1;
	public var endTime:Float;
	public var timeScale:Float = 1;
	public var mixTime:Float;
	public var mixDuration:Float;
	public var mix:Float = 1;
	public var onStart:Function;
	public var onEnd:Function;
	public var onComplete:Function;
	public var onEvent:Function;
	public function toString():String {
		return animation == (null) ? "<none>" : animation.name;
	}

	public function new() {
	}
}

class TrackEntryPool {
	var objs:Array<TrackEntry>;
	
	public function new() {
		objs = [];
	}
	
	public function free(obj:TrackEntry) {
		obj.next = obj.previous = null;
		obj.animation = null;
		obj.onStart = obj.onEnd = obj.onComplete = obj.onEvent = null;
		obj.lastTime = -1;
		obj.timeScale = 1;
		obj.time = 0;
		objs.push(obj);
	}
	
	public function get() {
		if (objs.length > 0) {
			return objs.pop();
		}
		return new TrackEntry();
	}
}