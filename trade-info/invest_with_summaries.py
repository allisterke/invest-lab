# Copyright 2015 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

"""A simple MNIST classifier which displays summaries in TensorBoard.

 This is an unimpressive MNIST model, but it is a good example of using
tf.name_scope to make a graph legible in the TensorBoard graph explorer, and of
naming summary tags so that they are grouped meaningfully in TensorBoard.

It demonstrates the functionality of every TensorBoard dashboard.
"""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import numpy as np
import tensorflow as tf

import sys

flags = tf.app.flags
FLAGS = flags.FLAGS
flags.DEFINE_boolean('fake_data', False, 'If true, uses fake data '
                     'for unit testing.')
flags.DEFINE_integer('max_steps', 5111, 'Number of steps to run trainer.')
flags.DEFINE_float('learning_rate', 0.001, 'Initial learning rate.')
flags.DEFINE_float('dropout', 0.9, 'Keep probability for training dropout.')
flags.DEFINE_string('data_dir', '/tmp/data', 'Directory for storing data')
flags.DEFINE_string('summaries_dir', '/tmp/invest_logs', 'Summaries directory')
flags.DEFINE_integer('dimension', 60, 'vector dimension')
flags.DEFINE_integer('category', 6, 'price variation category')
flags.DEFINE_integer('hidden_1_dim', 200, 'dimension of first hidden layer')
flags.DEFINE_integer('hidden_2_dim', 200, 'dimension of second hidden layer')
flags.DEFINE_string('train_vector', sys.argv[1], '')
flags.DEFINE_string('train_label', sys.argv[2], '')
flags.DEFINE_string('test_vector', sys.argv[3], '')
flags.DEFINE_string('test_label', sys.argv[4], '')

def read_vectors(filename):
  with open(filename, 'r') as f:
    vectors = []
    for line in f.readlines():
      ds = line.split()
      v = []
      for d in ds:
        v.append(float(d))
      vectors.append(v)
    FLAGS.dimension = len(vectors[0])
    return np.array(vectors, dtype=np.float32)

def read_labels(filename):
  with open(filename, 'r') as f:
    labels = []
    for line in f.readlines():
      ls = line.split()
      v = []
      for l in ls:
        v.append(int(l))
      labels.append(v)
    FLAGS.category = len(labels[0])
    return np.array(labels, dtype=np.uint8)

def read_data():
  class Invest(object):
    pass
  invest = Invest()

  invest.train_vectors = read_vectors(FLAGS.train_vector)
  invest.train_labels = read_labels(FLAGS.train_label)

  invest.test_vectors = read_vectors(FLAGS.test_vector)
  invest.test_labels = read_labels(FLAGS.test_label)

  return invest

def train():
  # Import data

  invest = read_data()

  sess = tf.InteractiveSession()

  # Create a multilayer model.

  # Input placehoolders
  with tf.name_scope('input'):
    x = tf.placeholder(tf.float32, [None, FLAGS.dimension], name='x-input')
#    image_shaped_input = tf.reshape(x, [-1, 28, 28, 1])
#    tf.image_summary('input', image_shaped_input, 10)
    y_ = tf.placeholder(tf.float32, [None, FLAGS.category], name='y-input')
    keep_prob = tf.placeholder(tf.float32)
#    tf.scalar_summary('dropout_keep_probability', keep_prob)

  # We can't initialize these variables to 0 - the network will get stuck.
  def weight_variable(shape):
    """Create a weight variable with appropriate initialization."""
    initial = tf.truncated_normal(shape, stddev=0.1)
    return tf.Variable(initial)

  def bias_variable(shape):
    """Create a bias variable with appropriate initialization."""
    initial = tf.constant(0.1, shape=shape)
    return tf.Variable(initial)

  def variable_summaries(var, name):
    """Attach a lot of summaries to a Tensor."""
    with tf.name_scope('summaries'):
      mean = tf.reduce_mean(var)
      tf.scalar_summary('mean/' + name, mean)
      with tf.name_scope('stddev'):
        stddev = tf.sqrt(tf.reduce_sum(tf.square(var - mean)))
      tf.scalar_summary('sttdev/' + name, stddev)
      tf.scalar_summary('max/' + name, tf.reduce_max(var))
      tf.scalar_summary('min/' + name, tf.reduce_min(var))
      tf.histogram_summary(name, var)

  def nn_layer(input_tensor, input_dim, output_dim, layer_name, act=tf.nn.relu):
    """Reusable code for making a simple neural net layer.

    It does a matrix multiply, bias add, and then uses relu to nonlinearize.
    It also sets up name scoping so that the resultant graph is easy to read, and
    adds a number of summary ops.
    """
    # Adding a name scope ensures logical grouping of the layers in the graph.
    with tf.name_scope(layer_name):
      # This Variable will hold the state of the weights for the layer
      with tf.name_scope('weights'):
        weights = weight_variable([input_dim, output_dim])
#        variable_summaries(weights, layer_name + '/weights')
      with tf.name_scope('biases'):
        biases = bias_variable([output_dim])
#        variable_summaries(biases, layer_name + '/biases')
      with tf.name_scope('Wx_plus_b'):
        preactivate = tf.matmul(input_tensor, weights) + biases
#        tf.histogram_summary(layer_name + '/pre_activations', preactivate)
      activations = act(preactivate, 'activation')
#      tf.histogram_summary(layer_name + '/activations', activations)
      return activations

  hidden1 = nn_layer(x, FLAGS.dimension, FLAGS.hidden_1_dim, 'layer1')
  dropped = tf.nn.dropout(hidden1, keep_prob)
  hidden2 = nn_layer(dropped, FLAGS.hidden_1_dim, FLAGS.hidden_2_dim, 'hidden_layer2')
  dropped2 = tf.nn.dropout(hidden2, keep_prob)
  y = nn_layer(dropped2, FLAGS.hidden_2_dim, FLAGS.category, 'layer2', act=tf.nn.softmax)
#  y = nn_layer(dropped, FLAGS.hidden_1_dim, FLAGS.category, 'layer2', act=tf.nn.softmax)


  with tf.name_scope('cross_entropy'):
    diff = y_ * tf.log(y)
    with tf.name_scope('total'):
      cross_entropy = -tf.reduce_mean(diff)
#    tf.scalar_summary('cross entropy', cross_entropy)

  with tf.name_scope('train'):
    train_step = tf.train.AdamOptimizer(
        FLAGS.learning_rate).minimize(cross_entropy)

  with tf.name_scope('accuracy'):
    with tf.name_scope('correct_prediction'):
      correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
    with tf.name_scope('accuracy'):
      accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
#    tf.scalar_summary('accuracy', accuracy)

  # Merge all the summaries and write them out to /tmp/invest_logs (by default)
#  merged = tf.merge_all_summaries()
#  train_writer = tf.train.SummaryWriter(FLAGS.summaries_dir + '/train', sess.graph)
#  test_writer = tf.train.SummaryWriter(FLAGS.summaries_dir + '/test')
  tf.initialize_all_variables().run()

  # Train the model, and also write summaries.
  # Every 10th step, measure test-set accuracy, and write test summaries
  # All other steps, run train_step on training data, & add training summaries

  def feed_dict(train):
    """Make a TensorFlow feed_dict: maps data onto Tensor placeholders."""
    if train or FLAGS.fake_data:
#      xs, ys = invest.train.next_batch(100, fake_data=FLAGS.fake_data)
      xs, ys = invest.train_vectors, invest.train_labels
      k = FLAGS.dropout
    else:
#      xs, ys = invest.test.vectors, invest.test.labels
      xs, ys = invest.test_vectors, invest.test_labels
      k = 1.0
    return {x: xs, y_: ys, keep_prob: k}

  for i in range(FLAGS.max_steps):
    if i % 10 == 0:  # Record summaries and test-set accuracy
      train_acc = sess.run(accuracy, feed_dict=feed_dict(True))
#      summary, acc = sess.run([merged, accuracy], feed_dict=feed_dict(False))
      acc = sess.run(accuracy, feed_dict=feed_dict(False))
#      test_writer.add_summary(summary, i)
      print('Accuracy at step %s: train=%s, test=%s' % (i, train_acc, acc))
    else: # Record train set summarieis, and train
#      summary, _ = sess.run([merged, train_step], feed_dict=feed_dict(True))
      sess.run(train_step, feed_dict=feed_dict(True))
#      train_writer.add_summary(summary, i)

  result = sess.run(tf.argmax(y, 1), feed_dict=feed_dict(False)) 
  with open('result.txt', 'w') as f:
    for r in result:
      print(r, file=f)

def main(_):
  if tf.gfile.Exists(FLAGS.summaries_dir):
    tf.gfile.DeleteRecursively(FLAGS.summaries_dir)
  tf.gfile.MakeDirs(FLAGS.summaries_dir)
  train()

if __name__ == '__main__':
  tf.app.run()
