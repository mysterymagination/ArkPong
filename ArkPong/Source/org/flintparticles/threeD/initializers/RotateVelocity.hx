/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author:Richard Lord
 * Copyright(c)Richard Lord 2008-2010
 * http://flintparticles.org
 * 
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files(the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.flintparticles.threeD.initializers 
{
import org.flintparticles.common.emitters.Emitter;
import org.flintparticles.common.initializers.InitializerBase;
import org.flintparticles.common.particles.Particle;
import org.flintparticles.threeD.geom.Vector3D;
import org.flintparticles.threeD.particles.Particle3D;	

/**
 * The RotateVelocity Initializer sets the angular velocity of the particle.
 * It is usually combined with the Rotate action to rotate the particle
 * using this angular velocity.
 */

class RotateVelocity extends InitializerBase
{
	private var _max:Float;
	private var _min:Float;
	private var _axis:Vector3D;

	/**
	 * The constructor creates a RotateVelocity initializer for use by 
	 * an emitter. To add a RotateVelocity to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 *<p>The angularVelocity of particles initialized by this class
	 * will be a random value between the minimum and maximum
	 * values set. If no maximum value is set, the minimum value
	 * is used with no variation.</p>
	 * 
	 * @param minAngVelocity The minimum angularVelocity, in 
	 * radians per second, for the particle's angularVelocity.
	 * @param maxAngVelocity The maximum angularVelocity, in 
	 * radians per second, for the particle's angularVelocity.
	 * 
	 * @see org.flintparticles.common.emitters.Emitter#addInitializer()
	 */
	public function new(axis:Vector3D=null, minAngVelocity:Float=0, maxAngVelocity:Float=NaN)
	{
		this.axis=axis;
		this.minAngVelocity=minAngVelocity;
		this.maxAngVelocity=maxAngVelocity;
	}
	
	/**
	 * The axis for the rotation.
	 */
	public var axis(get_axis, set_axis):Vector3D;
 	private function get_axis():Vector3D
	{
		return _axis;
	}
	private function set_axis(value:Vector3D):Void
	{
		_axis=value;
	}
	
	/**
	 * The minimum angular velocity value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	public var minAngVelocity(get_minAngVelocity, set_minAngVelocity):Float;
 	private function get_minAngVelocity():Float
	{
		return _min;
	}
	private function set_minAngVelocity(value:Float):Void
	{
		_min=value;
	}
	
	/**
	 * The maximum angular velocity value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	public var maxAngVelocity(get_maxAngVelocity, set_maxAngVelocity):Float;
 	private function get_maxAngVelocity():Float
	{
		return _max;
	}
	private function set_maxAngVelocity(value:Float):Void
	{
		_max=value;
	}
	
	/**
	 * When reading, returns the average of minAngVelocity and maxAngVelocity.
	 * When writing this sets both maxAngVelocity and minAngVelocity to the 
	 * same angular velocity value.
	 */
	public var angVelocity(get_angVelocity, set_angVelocity):Float;
 	private function get_angVelocity():Float
	{
		return _min==_max ? _min:(_max + _min)/ 2;
	}
	private function set_angVelocity(value:Float):Void
	{
		_max=_min=value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize(emitter:Emitter, particle:Particle):Void
	{
		var p:Particle3D=Particle3D(particle);
		var angle:Float;
		if(isNaN(_max))
		{
			angle=_min;
		}
		else
		{
			angle=_min + Math.random()*(_max - _min);
		}
		p.angVelocity.assign(axis).scaleBy(angle);
	}
}